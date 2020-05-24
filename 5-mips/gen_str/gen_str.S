    .text
    .type gen_str, @function
    .globl gen_str
gen_str:
    move    $t0, $a0        # $t0 = $a0
    li      $t1, 0x30       # $t1 = 0x30
L1:
    sb      $t1, 0($t0)     # 
    addiu   $t1, $t1, 1     # $t1 = $t1 + 1
    sltiu   $t3, $t1, 0x3a  # $t3 = $t1 < 0x3a?
    addiu   $t0, $t0, 1     # $t0 = $t0 + 1
    bgtz	$t3, L1         # if $t3 > 0, L1
    
    jr      $ra
