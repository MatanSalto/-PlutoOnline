# Use an existing base image as the starting point
FROM ubuntu:latest AS build

# Update the package list
RUN apt-get update

# Install NASM and LD
RUN apt-get install -y nasm binutils

# Copy the assembly code into the container
COPY assembly.asm /app/

# Assemble and link the code
RUN nasm -f elf64 -o /app/assembly.o /app/assembly.asm
RUN ld -m elf_x86_64 -s -o /app/assembly /app/assembly.o

# Use a minimal image as the final image
FROM alpine:latest

# Copy the executable from the build stage
COPY --from=build /app/assembly /app/

# Run the executable
CMD ["/app/assembly", ">", "/app/output.txt"]