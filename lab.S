######################################################
# Lab 9 template file
######################################################

######################################################
# .data is where variables will reside.
# We define the following below so you know what 
# their values are.
.data
.global lowercase_string
lowercase_string:
    // Specify a string ending with '\0'
    .asciz "ece 362 is awesome!"

// Align to 4bytes boundary as we have a string above
.balign 4
######################################################


######################################################
# All code goes in the .text section
.text

.global asm_strlen
asm_strlen:
    /* uint32_t asm_strlen(char *str)
     * Take in a pointer to a string and return
     * its length up to the null terminating
     * character `\0`
    **/   

    /* Enter your code after this comment */
    
    beq x10, x0, _null // check if string = Null
    li x12, 0 // set length to 0

    _while:
        lbu x11, 0(x10) // curr char
        beq x11, x0, _while_end // string = \0 end it
        addi x12, x12, 1 // add 1 to length
        addi x10, x10, 1 // next char pos
        jal x0, _while
    _while_end:
        addi x10, x12, 0 // return length
        ret

    _null:
        li x10, 0 // return 0
        ret
    
    /* Enter your code above this comment */
    ret

.global asm_fib
asm_fib:
    /* void asm_fib(int *arr, uint32_t length)
     * Accept a pointer to an array of integer and
     * the length of the array, then generate fibonacci
     * series starting at `0` and store the result
     * back to the array `arr` at corresponding indices.
     **/

    /* Enter your code after this comment */

    beq x10, x0, _return // arr == NULL -> return
    beq x11, x0, _return // length == 0 -> return

    li x12, 0 // prev = Fn-2
    li x13, 1 // curr = Fn-1
    li x14, 0 // i = 0
    li x7, 1 // check with i == 1

    _for:
        bge x14, x11, _for_end // check if i > length
        // access arr[i]
        li x15, 4
        mul x6, x14, x15
        add x16, x10, x6
        // if statements
        beq x14, x0, _if // i == 0
        beq x14, x7, _else_if // i == 1
        blt x7, x14, _else // i > 1
    _if:
        sw x12, 0(x16) // arr[i] = prev
        jal x0, _end_if
    _else_if:
        sw x13, 0(x16) // arr[i] = curr
        jal x0, _end_if
    _else:
        addi x5, x13, 0 // temp = curr
        add x13, x13, x12 // curr += prev
        addi x12, x5, 0 // prev = temp
        sw x13, 0(x16) // arr[i] = curr
        jal x0, _end_if
    _end_if:
        addi x14, x14, 1 // i++
        jal x0, _for
    _for_end:
        ret

    _return:
        ret


    /* Enter your code above this comment */
    ret

.global asm_toUppercase
asm_toUppercase:
    /* void asm_toUppercase(char *str)
     * loop through an entire string and only convert
     * the lowercase letter to uppercase, leaving the
     * rest of the string intact
     **/

    /* Enter your code after this comment */

    beq x10, x0, _invalid // string == NULL
    li x12, 97 // lowercase a
    li x13, 122 // lowercase z

    _UpCase_while:
        lbu x11, 0(x10) // curr char (char c)
        beq x11, x0, _UpCase_while_end // string = \0 end it
        blt x11, x12, _UpCase_end_if // c < a
        blt x13, x11, _UpCase_end_if // z < c
        bge x13, x11, _then // z >= c
    _then:
        addi x11, x11, -32 // lowercase to uppercase
        sb x11, 0(x10) // upper to string
        jal x0, _UpCase_end_if
    _UpCase_end_if:
        addi x10, x10, 1 // str++
        jal x0, _UpCase_while
    _UpCase_while_end:
        ret

    _invalid:
        ret
    
    
    /* Enter your code above this comment */
    ret


######################################################