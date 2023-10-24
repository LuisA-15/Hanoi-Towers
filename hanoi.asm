# Algoritmo Torres de Hanoi
# Yochabel Martinez Cazares
# Luis Raul Acosta Mendoza

.text
	addi s0, zero, 5	# Cantidad de discos
	
	lui s1, 0x10010		# Cargar tope de torre 1
	
					# Llenar la torre de abajo hacia arriba
	addi t0, zero, 1		# for (int i = 1;
llenarTorre:	blt s0, t0, continue	# i <= 5; (Si 5 < i, sale del ciclo)
		sw t0, 0(s1)		# Torre1[i] = i
		addi s1, s1, 0x20	# Avanzar al siguiente nivel de la torre 1
		addi t0, t0, 1		# i++;)
		jal llenarTorre

continue:	nop
	addi s1, s1, -0x20	# Mover pointer de torre 1 a su base
	addi s2, s1, 4		# pointer a la base de torre 2
	addi s3, s1, 8		# pointer a la base de torre 3
	
	
	add a2, zero, s1	# Torre inicial
	add a3, zero, s2	# Torre auxiliar
	add a4, zero, s3	# Torre final
	add a5, zero, s4	# Torre temp (Para hacer swaps)
	addi t1, zero, 1	# Registro usado despues para comparar con 1

	jal hanoi
	jal end
hanoi:	bne s0, t1, hanoirecursive	# if (n != 1)
	# Mover de torre inicial a torre final
	lw t2, 0(a2)		# Cargar el valor del disco de la torre inicial
	sw zero, 0(a2)		# Quitar el disco de la torre inicial
	sw t2, 0(a4)		# Cargar el disco en la torre final
	
	jalr ra
	
hanoirecursive: nop
	
	addi sp, sp, -20
	sw ra, 16(sp)		# Push ra a stack
	sw s0, 12(sp)		# Push n a stack
	sw a2, 8(sp)		# Push torre inicial a stack
	sw a3, 4(sp)		# Push torre auxiliar a stack
	sw a4, 0(sp)		# Push torre final a stack
	
	addi s0, s0, -1		# n -= 1
	add a5, zero, a3	#
	add a3, zero, a4	# Swap(Torre auxiliar, Torre final)
	add a4, zero, a5	#
	
	addi a2, a2, -0x20	#
	addi a3, a3, -0x20	# Mover los apuntadores a torres al nivel que corresponde
	addi a4, a4, -0x20	#
	
	jal hanoi		# hanoi(n - 1, torre inicial, torre final, torre auxiliar)
	
	lw a4, 0(sp)		# pop de torre final del stack
	lw a3, 4(sp)		# pop de torre auxiliar del stack
	lw a2, 8(sp)		# pop de torre inicial del stack
	lw s0, 12(sp)		# pop de n del stack
	lw ra, 16(sp)		# pop de ra del stack
	addi sp, sp, 20
	
	# Mover de inicial a Final
	lw t2, 0(a2)		# Cargar el valor del disco de la torre inicial
	sw zero, 0(a2)		# Quitar el disco de la torre inicial
	sw t2, 0(a4)		# Cargar el disco en la torre final
	
	addi sp, sp, -20
	sw ra, 16(sp)		# Push ra a stack
	sw s0, 12(sp)		# Push n a stack
	sw a2, 8(sp)		# Push torre inicial a stack
	sw a3, 4(sp)		# Push torre auxiliar a stack
	sw a4, 0(sp)		# Push torre final a stack
	
	addi s0, s0, -1		# n -= 1
	add a5, zero, a2	#
	add a2, zero, a3	# Swap(Torre inical, Torre auxiliar)
	add a3, zero, a5	#
	
	addi a2, a2, -0x20	#
	addi a3, a3, -0x20	# Mover los apuntadores a torres al nivel que corresponde
	addi a4, a4, -0x20	#
	
	jal hanoi		# hanoi(n - 1, torre auxiliar, torre inicial, torre final)
	
	lw a4, 0(sp)		# pop de torre final del stack
	lw a3, 4(sp)		# pop de torre auxiliar del stack
	lw a2, 8(sp)		# pop de torre inicial del stack
	lw s0, 12(sp)		# pop de n del stack
	lw ra, 16(sp)		# pop de ra del stack
	addi sp, sp, 20
	
	jalr ra
	
end: nop
	
