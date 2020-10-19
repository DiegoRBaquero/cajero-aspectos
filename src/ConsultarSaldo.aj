import java.util.List;

import ejemplo.cajero.control.Comando;
import ejemplo.cajero.control.ComandoListarCuentas;

public aspect ConsultarSaldo {
	pointcut cargaComandos() : call( * ejemplo.cajero.Cajero.cargaComandos(..));
	
	List<Comando> around() : cargaComandos() {

		List<Comando> comandos = proceed();
		comandos.add(new ComandoListarCuentas());
		return comandos;
	}
}