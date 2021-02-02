;; Import nonfree linux module.
(use-modules (gnu)
             (nongnu packages linux)
             (nongnu system linux-initrd))
(use-service-modules desktop networking  ssh xorg)

(operating-system
  (kernel linux)
  (initrd microcode-initrd)
  (firmware (list linux-firmware))
  (locale "en_SE.utf8")
  (timezone "Europe/Stockholm")
  (keyboard-layout (keyboard-layout "us" "dvorak"))
  (host-name "t14s")
  (users (cons* (user-account
                 (name "peter")
                 (comment "Peter Lejon")
                 (group "users")
                 (home-directory "/home/peter")
                 (supplementary-groups
                  '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))
 
 (packages
  (append
   (list (specification->package "emacs")
         (specification->package "emacs-exwm")
         (specification->package 
           "emacs-desktop-environment")
         (specification->package "nss-certs"))
   %base-packages))
 (services %desktop-services)
 (bootloader
  (bootleader-configuration
   (bootloader grub-efi-bootloader)
   (target "/boot/efi")
   (keyboard-layout keyboard-layout)))
 (file-systems
  (cons* (file-system
          (mount-point "/boot/efi")
          (device (uuid "xxxx" 'fat32))
          (type "vfat"))
         (file-system
          (mount-point "/")
          (device
           (uuid "xxxx" 'ext4))
          (type "ext4"))
         %base-file-system)))
