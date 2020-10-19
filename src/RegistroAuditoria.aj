import java.sql.Timestamp;
import java.util.List;

import ejemplo.cajero.control.Comando;
import ejemplo.cajero.control.ComandoListadoOperaciones;
import ejemplo.cajero.control.ComandoRegistroAuditoria;
import ejemplo.cajero.control.ComandoTransferir;
import ejemplo.cajero.modelo.Banco;
import ejemplo.cajero.modelo.Cuenta;

public aspect RegistroAuditoria {
	
	private String now() {
		return (new Timestamp(System.currentTimeMillis())).toLocaleString();
	}
	
	private ComandoRegistroAuditoria comando = new ComandoRegistroAuditoria();

	pointcut cargaComandos() : call( * ejemplo.cajero.Cajero.cargaComandos(..));
	
	List<Comando> around() : cargaComandos() {

		List<Comando> comandos = proceed();
		comandos.add(comando);
		return comandos;
	}

	pointcut metodosDeControl() : call( * ejemplo.cajero.control..*.ejecutar(Banco));
	
	before(Banco b): metodosDeControl() && args(b){

		comando.agregarRegistro(now() + " Operación: " + ((Comando) thisJoinPoint.getTarget()).getNombre());
	}
	
	after(Banco b) returning(Object resultado): metodosDeControl() && args(b) {

		if (resultado != null) {
			comando.agregarRegistro("\t resultado : " + resultado);
		}	
	}

	
	after(Banco b) throwing(Throwable e): metodosDeControl() && args(b) {

	    comando.agregarRegistro("\t excepción: " + e.getMessage());
	}	
	
	pointcut metodosDeCuenta() : call( * ejemplo.cajero.modelo.Cuenta.consignar(long)) || call( * ejemplo.cajero.modelo.Cuenta.retirar());
	
	before() : metodosDeCuenta() {
		comando.agregarRegistro("\t Cuenta: " + ((Cuenta) thisJoinPoint.getTarget()).getNumero());
		comando.agregarRegistro("\t Monto: " + thisJoinPoint.getArgs()[0].toString());
	}
	
	after() returning(Object resultado) : metodosDeCuenta() {

		if (resultado != null) {
			comando.agregarRegistro("\t resultado : " + resultado);
		}
	}

	
	after() throwing(Throwable e) : metodosDeCuenta() {

	    comando.agregarRegistro("\t excepción: " + e.getMessage());
	}	
}
