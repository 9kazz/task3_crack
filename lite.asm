.286
.model tiny
JUMPS
locals @@
.code
org 100h

;==================================================================================================================

Start:              call Main
                    mov ax, 4c00h
                    int 21h

Main                proc

                    mov ah, 09h
                    mov dx, offset Text_1
                    int 21h

                    mov ah, 0ah                     ; password input into the Password_buf
                    mov dx, offset Password_buf
                    int 21h

                    mov ah, 09h
                    mov dx, offset Text_2
                    int 21h

                    mov ah, 0ah                     ; input user review
                    mov dx, offset User_review
                    int 21h

                    mov si, offset Cor_Password
                    mov di, offset Password_buf + 2 ; the next char after buffer size info (0ah int 21h)
                    xor ch, ch
                    mov cl, Password_len
@@str_cmp:          cmpsb
                    jne @@access_denied
                    loop @@str_cmp

@@access_granted:   mov ah, 09h
                    mov dx, offset Success_ans
                    int 21h
                    ret

@@access_denied:    mov ah, 09h
                    mov dx, offset Failure_ans
                    int 21h
                    ret

                    endp

;------------------------------------------------------------------------------------------------------------------

Password_len        = 5
Password_buf        db 2* Password_len + 3, 7 dup(0)
Cor_Password        db "12345"
User_review         db 10, 12 dup(0)
Failure_ans         db 0dh, 0ah, "Access denied!$", 1 dup(?)
Success_ans         db 0dh, 0ah, "Access granted!$"

Text_1              db "Enter the password:$"
Text_2              db "Do you like this program? Your opinion is veeeery important for us!$"

;------------------------------------------------------------------------------------------------------------------

end                 Start