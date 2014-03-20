/*
 * This file contains a possible interpretation of the ppc32 microcode.
 * Code starts at address 0xFFF03000
 *
 * NOTE: cpu exceptions not included (see ...head.S file)
 *
 * I'm using a different gcc from the original (4.2.0) so the generated 
 * assembly is different.
 *
 * Inspection procedure:
 * 1) compile with -O1
 * 2) for each function:
 * 2.1) compare assembly
 * 2.2) while changes are needed: modify source, recompile and recompare
 * 2.3) annotate result
 * 3) if source changed: restart inspection
 * 4) review comments, test-compile and commit
 *
 * Flávio J. Saraiva
 */

#if defined(HAVE_STDARG_H)
#include <stdarg.h>
#else
// assume it's compatible with my version: powerpc-unknown-elf-gcc (crosstool-NG 1.19.0) 4.3.2
#define va_list           __builtin_va_list
#define va_start(x,a)     __builtin_va_start(x,a)
#define va_end(x)         __builtin_va_end(x)
#define va_arg(x,t)       __builtin_va_arg(x,t)
//#define va_copy(y,x)    __builtin_va_copy(y,x)
#endif

/**
 * Access to the custom remote control device.
 * Starts at 0xF6000000.
 * Reading and writing to these addresses can have side-effects.
 */
struct remote_dev {
  unsigned int rom_id; // (r) ROM identification = 0x1e94b3df
  unsigned int cpu_id; // (r)
  unsigned int display_cpu_registers; // (w)
  unsigned int display_cpu_memory_info; // (w)
  unsigned int unused_0010; // unused
  unsigned int ram_size; // (r) available RAM size in megabytes
  unsigned int rom_size; // (r)
  unsigned int nvram_size; // (r)
  unsigned int iomem_size; // (r) IOMEM in megabytes (RAM reserved for packets) 
  unsigned int config_reg; // (r)
  unsigned int elf_entry_point; // (r) entry point of the IOS image
  unsigned int elf_machine_id; // (r) machine ID of the IOS image
  unsigned int restart_ios; // (rw?) NOT IMPLEMENTED
  unsigned int stop_virtual_machine; // (rw) Stop the virtual machine
  unsigned int debug_message; // (w) write debug message to log file
  unsigned int log_output; // (w) write character to log buffer (written to log file on '\n')
  unsigned int console_output; // (w) write character to console
  unsigned int nvram_address; // (r)
  unsigned int io_memory_size; // (r) IO memory size for Smart-Init (C3600, others?)
  unsigned int cookie_position; // (rw) Cookie position selector
  unsigned int cookie_data; // (r) Cookie data
  unsigned int rommon_variable; // (rw)
  unsigned int rommon_variable_command; // (rw)
};
#define ROM_ID                  0x1e94b3df
#define ROMMON_SET_VAR          1
#define ROMMON_GET_VAR          2
#define ROMMON_CLEAR_VAR_STAT   3
#define remote_ctrl   ( *((volatile struct remote_dev*)0xF6000000) )
#define nvram_7E0     ( *((volatile unsigned int*)(remote_ctrl.nvram_address+0x7E0)) )


#define CONSOLE   0
#define LOG       1
#define TO_HEX(x)   ( ((x) <= 9)? '0'+(x): 'a'-10+(x) )
int remote_print(int stream, char* fmt, ...);
void remote_put_char(int stream, char c);
void remote_put_string(int stream, char* str);
void inline crash(void);



/**
 * This data starts at address 0x4000.
 */
struct bss_data {
  // registers saved and restored for a syscall
  unsigned int _r8;
  unsigned int _r9;
  unsigned int _r10;
  unsigned int _LR;
  unsigned int _XER;
  unsigned int _CR;

  unsigned int unused_18;
  unsigned int unused_1C;

  char* nvram_bootldr; // nvram_address+0x200 (set to "BOOTLDR" at startup)
  char* nvram_ios; // nvram_address+0x80 (set to "IOS" at startup)
  unsigned int nvram_780; // nvram_address+0x780

  unsigned int unused_2C;
  unsigned int unused_30;
  unsigned int unused_34;
  unsigned int unused_38;
  unsigned int unused_3C;
};
struct bss_data __attribute__((section(".bss"))) data;


/**
 * Copy len bytes from src to dst.
 *
 * WARNING: expects len > 0, buffer overflow for len == 0
 *
 * Inspection: PASS - called by cpu_exception_00100 (see ...head.S)
 * - equivalent assembly
 */
void my_memcpy(char* dst, char* src, unsigned int len)
{
  do {
    *dst++ = *src++;
  } while (--len);
}


/**
 * Launch the ISO image by calling the target address.
 * 
 * Inspection: PASS
 * - same assembly
 * - the function restart_image should be a label before the blr (return) instruction
 */
void launch_image(unsigned int addr)
{
  // FIXME: save the current state
  asm("mtctr %0"::"r"(addr));
  asm("li %r3, 2");
  asm("li %r4, 0");
  asm("li %r5, 0");
  asm("mtcr %r4");// CR = 0
  asm("mtxer %r4");// XER = 0
  asm("bctrl");// call addr(2,0,0)
  // XXX: can asm fix restart_image? "lbl_restart_image:"
  return;
}


/**
 * Restart the IOS image.
 *
 * /!\ BROKEN /!\ No way just jumping to the end of launch_image can work... >.>
 *
 * Needs to restore the registers to before the IOS image is launched.
 *
 * Inspection: FAIL->PASS - equivalent since there is only a blr instruction
 * - equivalent assembly
 * - should be a label before the blr (return) instruction in the function launch_image
 */
void restart_image(unsigned int addr)
{
  // XXX: can asm fix restart_image? "b lbl_restart_image"
  // FIXME: restore state saved in launch_image
  return;
}


/**
 * Copy string from src to dst.
 *
 * WARNING: does not copy NUL byte
 *
 * Inspection: PASS
 * - equivalent assembly
 */
void my_strcpy(char* dst, char* src)
{
  while (*src) {
    *dst++ = *src++;
  }
}


/**
 * Copy up to len bytes from string src to dst.
 *
 * WARNING: does not NUL terminate buffer if string is too big
 *
 * Inspection: PASS - unused
 * - equivalent assembly
 */
void my_strncpy(char* dst, char* src, unsigned int len)
{
  for (; len; --len) {
    if (!(*dst++ = *src++))
      return;
  }
}


/**
 * Get the string length.
 *
 * Inspection: PASS - unused
 * - equivalent assembly
 */
unsigned int my_strlen(char* str)
{
  unsigned int len = 0;
  for (len = 0; *str++; ++len)
    ;
  return len;
}


/**
 * Print to the console or log.
 *
 * Inspection: PASS
 * - equivalent assembly
 * - out of order (placed before start_microcode)
 */
int remote_print(int stream, char* fmt, ...)
{
  va_list ap;
  va_start(ap, fmt);
  for(; *fmt; ++fmt) {
    if (*fmt != '%') {
      char c = *fmt;
      remote_put_char(stream, c);
      continue;
    }
    ++fmt;
    switch (*fmt) {
    case '%':
      remote_put_char(stream, '%');
      break;

    case 'c': {
      remote_put_char(stream, (char)va_arg(ap, unsigned int));
      break;
    }

    case 's': {
      char* str = va_arg(ap, char*);
      if (str == 0)
        str = "(null)";
      remote_put_string(stream, str);
      break;
    }

    case 'x': {
      unsigned int val = va_arg(ap, unsigned int);
      remote_put_char(stream, (char)TO_HEX((val&0xF0000000) >> 28));
      remote_put_char(stream, (char)TO_HEX((val&0x0F000000) >> 24));
      remote_put_char(stream, (char)TO_HEX((val&0x00F00000) >> 20));
      remote_put_char(stream, (char)TO_HEX((val&0x000F0000) >> 16));
      remote_put_char(stream, (char)TO_HEX((val&0x0000F000) >> 12));
      remote_put_char(stream, (char)TO_HEX((val&0x00000F00) >>  8));
      remote_put_char(stream, (char)TO_HEX((val&0x000000F0) >>  4));
      remote_put_char(stream, (char)TO_HEX((val&0x0000000F)      ));
      break;
    }
    }
  }
  va_end(ap);
  return 0;
}


/**
 * Read a ROMMON variable.
 *
 * WARNING: buffer overflow for buflen <= 1
 *
 * Inspection: PASS
 * - equivalent assembly
 */
int read_bootvar(char* name, char* buf, int buflen)
{
  // write variable name
  for (; *name; ++name)
    remote_ctrl.rommon_variable = *name;
  // load contents
  remote_ctrl.rommon_variable_command = ROMMON_GET_VAR;
  if (remote_ctrl.rommon_variable_command)
    return -1; // not found?
  // copy contents
  int n;
  for (n = (buflen - 1 <= 0)? 1: buflen - 1; n; --n) {
    *buf++ = (char)remote_ctrl.rommon_variable;
    *buf = 0;
  }
  remote_ctrl.rommon_variable_command = ROMMON_CLEAR_VAR_STAT;
  return 0;
}


/**
 * Write a ROMMON variable.
 *
 * Inspection: PASS
 * - equivalent assembly
 */
int write_bootvar(char* name_value)
{
  // write name-value
  for (; *name_value; ++name_value)
    remote_ctrl.rommon_variable = *name_value;
  // store contents
  remote_ctrl.rommon_variable_command = ROMMON_SET_VAR;
  return 0x800;
}


/**
 * Handle a system call exception.
 *
 * Inspection: PASS - called by cpu_exception_00C00 (see ...head.S)
 * - equivalent assembly
 * - out of order (placed after start_microcode)
 * - does not inline crash
 */
int syscall_handler(unsigned int syscall, unsigned int a1, unsigned int a2, unsigned int a3, unsigned int pc)
{
  switch (syscall) {
  default: { // unhandled syscall
    remote_print(LOG, "unhandled syscall 0x%x at pc=0x%x (a1=0x%x,a2=0x%x,a3=0x%x)\n", syscall, pc, a1, a2, a3);
    return -1;
  }

  case 58:
  case 74: { // TODO unknown
    return -1;
  }

  case 4:
  case 132: { // get available RAM size in bytes (from megabytes)
    return (remote_ctrl.ram_size << 20);
  }

  case 44: { // read cookie
    unsigned short* buf = (unsigned short*)a1;
    unsigned int i;
    for (i = 0; i < 64; ++i) {
      remote_ctrl.cookie_position = i;
      buf[i] = (unsigned short)remote_ctrl.cookie_data;
    }
    return 0;
  }

  case 48:
  case 49: { // TODO unknown
    return 0;
  }

  case 6: { // get config register (bits inverted)
    return ~remote_ctrl.config_reg;
  }

  case 1: { // print to console
    char c = (char)a1;
    remote_put_char(CONSOLE, c);
    return 0;
  }

  case 46: { // read ROMMON variable
    char* name = (char*)a1;
    char* buf = (char*)a2;
    unsigned int buflen = (unsigned int)a3;
    remote_print(LOG, "trying to read bootvar '%s'\n", name);
    return read_bootvar(name, buf, buflen);
  }

  case 45: { // write ROMMON variable
    char* name_value = (char*)a1;
    remote_print(LOG, "trying to set bootvar '%s'\n", name_value);
    return write_bootvar(name_value);
  }

  case 43: { // stop the virtual machine
    remote_ctrl.stop_virtual_machine = 1;
    return 0;
  }

  case 37: { // TODO unknown
    char* str = (char*)a1;
    my_strcpy(data.nvram_ios, str);
    return 1;
  }

  case 36: { // TODO unknown
    return (unsigned int)data.nvram_bootldr;
  }

  case 35: { // TODO unknown
    char* str = (char*)a1;
    my_strcpy(data.nvram_bootldr, str);
    return 1;
  }

  case 34: { // TODO unknown
    return (unsigned int)data.nvram_ios;
  }

  case 28: { // get config register
    return remote_ctrl.config_reg;
  }

  case 27: { // get IOMEM size in bytes (from megabytes)
    return (remote_ctrl.iomem_size << 20);
  }

  case 24: { // get NVRAM size in bytes (from kilobytes)
    return (remote_ctrl.nvram_size << 10);
  }

  case 13: { // initial elf_entry_point
    return (unsigned int)data.nvram_780;
  }

  case 10: { // version string
    static const char* VERSION_STRING = "\n\nROMMON Emulation Microcode\n"; 
    return (unsigned int)VERSION_STRING;
  }

  case 8: { // restart IOS
    remote_print(CONSOLE, "\n\nROM: reload requested...\n");
    if (remote_ctrl.restart_ios) {
      remote_print(CONSOLE, "ROM: Restarting IOS...\n");
      restart_image(remote_ctrl.elf_entry_point);
      return 0;
    }
    else {
      remote_ctrl.stop_virtual_machine = 1;
      crash();
      return 0;
    }
  }

  case 7: { // get the machine id of the IOS image
    return remote_ctrl.elf_machine_id;
  }

  case 55: { // TODO unknown
    return 0x380;
  }

  case 47: { // TODO unknown
    return 0x800;
  }

  case 60: { // TODO unknown
    unsigned int io_memory_size = remote_ctrl.io_memory_size;
    if ((io_memory_size&0x8000) == 0 && nvram_7E0 != 0) {
      return 0;
    } else {
      return (io_memory_size&0x18000); // 32KiB or 96KiB
    }
  }

  case 2: { // TODO unknown
    return 0xC00;
  }

  case 54: { // TODO unknown
    return remote_ctrl.nvram_address+0x400;
  }

  case 59: { // TODO unknown (related to io_memory_size)
    nvram_7E0 = a1;
    return 1;
  }

  }
}


/**
 * Put a character in the console or log
 *
 * Inspection: PASS
 * - same assembly
 */
void remote_put_char(int stream, char c)
{
  if (stream) {
    remote_ctrl.log_output = c;
  }
  else {
    remote_ctrl.console_output = c;
  }
}


/**
 * Put a string in the console or log
 *
 * Inspection: PASS
 * - equivalent assembly
 */
void remote_put_string(int stream, char* str)
{
  if (*str == 0)
    return;
  if (stream) {
    for (; *str; ++str) {
      remote_ctrl.log_output = *str;
    }
  }
  else {
    for (; *str; ++str) {
      remote_ctrl.console_output = *str;
    }
  }
}


/**
 * Crash by calling NULL.
 *
 * Inspection: PASS
 * - same assembly
 */
void inline crash(void)
{
  ((void (*)(void))0)();
}


/**
 * Start the microcode.
 *
 * Inspection: PASS - called by cpu_exception_00100 (see ...head.S)
 * - equivalent assembly
 */
void start_microcode(void)
{
  // init
  remote_print(CONSOLE, "ROMMON emulation microcode.\n\n");
  remote_print(LOG, "Microcode has started.\n");
  if (remote_ctrl.rom_id != ROM_ID) {
    remote_print(CONSOLE, "The microcode need to be upgraded to match your emulator version.\n");
    crash();
  }

  data.nvram_ios = (char*)(remote_ctrl.nvram_address+0x80);
  my_strcpy(data.nvram_ios, "IOS");

  data.nvram_bootldr = (char*)(remote_ctrl.nvram_address+0x200);
  my_strcpy(data.nvram_bootldr, "BOOTLDR");

  data.nvram_780 = remote_ctrl.nvram_address+0x780;

  // run
  do {
    remote_print(CONSOLE, "Launching IOS image at 0x%x...\n", remote_ctrl.elf_entry_point);
    launch_image(remote_ctrl.elf_entry_point);
  } while(remote_ctrl.restart_ios);

  // terminate
  remote_print(CONSOLE, "Image returned to ROM.\n");
  remote_ctrl.stop_virtual_machine = 1;
}
