Cyclone IV: EP4CE22F17C6  

## Links Utiles
- [Practico 1](https://famaf.aulavirtual.unc.edu.ar/pluginfile.php/27421/mod_resource/content/0/TP1_%20SV%20y%20procesador%20de%20un%20ciclo.pdf)  
- [Practico 2](https://famaf.aulavirtual.unc.edu.ar/pluginfile.php/27649/mod_resource/content/2/Pr%C3%A1ctico%202_%20Test%20del%20procesador%20de%20un%20ciclo.pdf)  
- [Practico 3](https://famaf.aulavirtual.unc.edu.ar/pluginfile.php/27795/mod_resource/content/0/TP3_Procesador%20de%20un%20ciclo%20con%20excepciones.pdf)  
---

## Entrada/Salida del Sistema

- Periferal = logica de entrada/salida.  
- El usb es un periferal.  
- Los modulos de entrada salida se conectan mediante buses.  
- El procesador habla tanto con la memoria como con los periferals usando el mismo bus.  
- Registros de entrada/salida= palabra de memoria cuyo contenido esta relacionado al estado de un hardware determinado y que puede ser manipulado.
- En ARM los registros i/o son iguales a los registros de memoria. Se decodifican de la misma manera.
- Tanto I/O como Flash y RAM comparte un mismo espacio de direccionado.  
- Que un procesador sea de 64 bits quiere decir que los registros son de 64 bits, no que puede direccionar 2^64. Hoy en dia se estila que sean iguales.  
- Entre el hardware y el software estan los registros de los perifericos.

### Intel -> Standard I/O 
- Todas las instrucciones acceden a memoria.  
- Para acceder a los periferal tengo que usar instrucciones especiales In y Out. 
- Los espacios de direccionado estan separados entre memoria e i/o.  

### ARM -> Memory-Mapped I/O 
- Accedo a los perfierals usando Loads y Stores convencionales.  
- El espacio de direccionado es compartido entre RAM y I/O.  

---

## Operaciones i/o
- **Polling-driven**: entrada salida programada. Consultar repetidamente por codigo a los registros de i/o.  Consulta registros de estado. Se desprecian muchos ciclos de reloj revisando el estado del modulo.  
- **Interrupt-driven**
- **DMA**: Direct Memory Access.

- Los registros de control se escriben para dar una orden.

--- 

## Interrupciones
-  Es un quiebre en la ejecucion secuencial. Esta controlada por los modulos de entrada salida. Cuando el teclado genera una senal, le envia una interrupcion en el procesador. Este lee status para corroborar que se esta haciendo lo que se espera. Se lee el dato y se la lleva a memoria. En este caso no se desperdician ciclos de reloj (no se consumen ciclos de instruccion pq esto se realiza por hardware)para revisar estados continuamente.  
- Si hay una interrupcion, corto la secuencialidad y salto a una direccion determinada llamada vector de interrupciones donde esta el codigo con los procedimientos que sirven para atender a esa interrupcion.
- Este vector se llama ISR (Interrupt address vector).

### Alojamiento de la ISR
- Direccion fija: se usaba en arquis pequenas. Una direccion conocida determinada por el fabricante del procesador. En desuso.
- Direccion vectorizada: Hay muchas, un arreglo de direcciones. Cada una le dice al CPU donde esta. Se agrega una senal INT ACK que va del procesador al modulo io para avisarle que va a ser atendido.
Cada periferico sabe cual es su vector, el SO debe haber puesto correctamente que numero tiene ese periferico para poder atenderlo.

###Enmascarables
El programador puede modificar un bit para que el procesador ignore la repeticion.  

###No Enmascarables
No pueden ser ignoradas. Se asocian a eventos de sistema que no dependan de evento io. Se suelen conocer con el nombre de Traps.  

---

## Excepciones

### Handling Exceptions
- Guardar el PC de la instruccion que falla o fue interrumpida (ELR: Exception Link Register).  
- Guardar indicaciones del problema.


---

## Fordwarding
*Leer desde pagina 75 en adelante del pdf Chapter_04*.  

ADD X1, X1, X2
ADD X1, X1, X3
ADD X4, X1, X2
- En caso de un doble hazard, se hace el fordwarding desde la salida del execute, no desde el writeback. Ya que se necesita la salida del valor desde el execute.  

- Cuando el LOAD llego a la etapa mem, ahi se deberia fordwardear el dato, pero suponiendo que atras viene una instruccion que hace uso del registro destino que ella esta usando, por ejemplo un STORE, ahi va a tener que hacer un stall.

## Branchs

Con setear las senales del control en 0, deberia ser suficiente. Para hacer un flush a las instrucciones que van a ser descartadas despues de un branch, no es necesario descartar todo. Se puede flushear desde la etapa del MEM del branch hacia atras.