import java.util.List;

import ejemplo.cajero.control.Comando;
import ejemplo.cajero.control.ComandoRetirar;

public aspect RetirarDinero {
	pointcut cargaComandos() : call( * ejemplo.cajero.Cajero.cargaComandos(..));
	
	List<Comando> around() : cargaComandos() {

		List<Comando> comandos = proceed();
		comandos.add(new ComandoRetirar());
		return comandos;
	}
}