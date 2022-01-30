# Single user mode

If a user cannot establish a login session (for example, when their
`~/.profile` is misconfigured and badly provisioned), booting the system in
single user mode will provide a `root` shell to debug and remediate any
issues.

1. Start the machine and load into the boot manager (i.e.; GRUB).
2. Select/highlight the system's boot entry and press `e` to edit the kernel's
   `cmdline`.
3. Add the boot parameter "`init=/bin/bash`" to the `cmdline`, and then press
   `Ctrl+x` to continue.
4. Mount any necessary filesystem partitions (e.g.; if user home directories
   are mounted on separate partitions, if the root file system is initially
   mounted as read-only).
   - See `lsblk`, `mount`.
5. Perform any debugging/remediation.
6. Synchronize any writes (`sync`) and unmount (`umount`, or remount as
   read-only) any filesystems.
7. Power off or `exit` (the latter may cause a kernel panic).
