    .text
    .type printd, @function
    .globl printd
printd:
    move    $t0, $a0            # $t0 = $a0
    move    $t1, $sp            # $t1 = $sp
    addiu   $t1, $t1, -1        # $t1 += -1
    li      $t3, 10             # $t3 = 10

    li      $t2, '\n'           # $t2 = '\n'
    sb      $t2, 0($t1)         # 0($t1) = $t2

loop_start:
    addiu   $t1, $t1, -1        # $t1 += -1
    divu    $t0, $t3            # $t0 / $t3
    mflo    $t0                 # $t0 = $t0 / $t3
    mfhi    $t2                 # $t2 = $t0 % $t3 
    addiu   $t2, $t2, '0'       # $t2 = $t2 + '0'
    sb      $t2, 0($t1)         # 0($t1) = $t2
    bgtz    $t0, loop_start     # if $t0 > 0, to loop_start
loop_end:
    li      $v0, 4004           # function: io
    li      $a0, 1              # stream: stdout
    move    $a1, $t1            # address
    sub     $a2, $sp, $t1       # length: $t4 = $sp - $t1
    syscall
    jr      $ra                 # jump to $ra
