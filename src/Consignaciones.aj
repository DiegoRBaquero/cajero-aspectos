import java.util.List;

import ejemplo.cajero.control.Comando;
import ejemplo.cajero.control.ComandoConsignar;

public aspect Consignaciones {
	
	pointcut cargaComandos() : call( * ejemplo.cajero.Cajero.cargaComandos(..));
	
	List<Comando> around() : cargaComandos() {

		List<Comando> comandos = proceed();
		comandos.add(new ComandoConsignar());
		return comandos;
	}
}