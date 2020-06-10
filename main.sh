# Packages

#install-pkg nasm genisoimage bochs bochs-x

# Compile
nasm -f elf32 loader.s

ld -T link.ld -melf_i386 loader.o -o kernel.elf

# Build
mkdir -p iso/boot/grub
cp stage2_eltorito iso/boot/grub/
cp menu.lst iso/boot/grub
cp kernel.elf iso/boot/

# Compile .iso
genisoimage -R                              \
            -b boot/grub/stage2_eltorito    \
            -no-emul-boot                   \
            -boot-load-size 4               \
            -A os                           \
            -input-charset utf8             \
            -quiet                          \
            -boot-info-table                \
            -o os.iso                       \
            iso

# Run OS
#bochs
