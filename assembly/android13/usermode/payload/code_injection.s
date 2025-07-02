// code_injection.s - Usermode Code Injection Payload
// Simulates injecting code into a running process by "jumping" to a location.
// (In practice, this would perform more complex memory operations.)
.global _start
.section .text
_start:
    ldr x0, =msg
    br x0
.section .data
msg: .asciz "Usermode code injection simulated!\n"
