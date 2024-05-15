# Catalog of Verilog Components to Build and Simulate a MIPS-based RISC.

This work is based off the MIPS Verilog code by [Harris and Harris](https://pages.hmc.edu/harris/ddca/ddca2e.html)

# Demo Video
https://youtube.com/shorts/m1Cb7iYciyQ?si=AtZfaWyyl3JdEejF

  
# Demo Instruction, Example recursion program - Fibonacci
```

cd ./catalog/computer

make simulate compile
```

This will print results of the fib_seq_exe which calculates 6th fibonacci number, 5. Fib Also, it creates tb_computer.vcd file for gtkwave.

  
# Design Explanation

This design of single-cycle CPU implements a subset of an official MIPS greensheet.

![image](https://github.com/kmlagalbi/final-project-ece-251-spring-2024-bingchillin/assets/44723150/7203f7d4-0cec-46ed-8a8f-55b0b7d3c875)

32 bits ALU Operand Size, 32 bits Address Bus Size, Byte addressable, 32 32 bits Register, Memory Reference Support, Total Memory Size of 64 words.

# ISA

<img width="200" alt="Screen Shot 2024-05-14 at 8 15 36 PM" src="https://github.com/kmlagalbi/final-project-ece-251-spring-2024-bingchillin/assets/44723150/21c58ec6-de97-428d-83d6-ebdb4cc1c61b">

<img width="715" alt="Screen Shot 2024-05-14 at 8 22 59 PM" src="https://github.com/kmlagalbi/final-project-ece-251-spring-2024-bingchillin/assets/44723150/22de485c-9998-4ae0-ade1-578790cd2d29">

  
# R, I, J timing diagraam
<img width="477" alt="Screen Shot 2024-05-14 at 8 05 21 PM" src="https://github.com/kmlagalbi/final-project-ece-251-spring-2024-bingchillin/assets/44723150/597ee599-e25a-4f25-90a5-64a3ccb7d598">
```
add $s1, $s2, $s3
addi $s1, $s2, 0
jump j 0
```
