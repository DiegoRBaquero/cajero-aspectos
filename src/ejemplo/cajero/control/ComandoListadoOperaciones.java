package ejemplo.cajero.control;

import java.util.ArrayList;
import java.util.List;

import ejemplo.cajero.modelo.Banco;
import ejemplo.cajero.modelo.Cuenta;

/**
 * Comando usado para listar las cuentas 
 */
public class ComandoListadoOperaciones implements Comando {

	private List<String> registros = new ArrayList<String>();
	
	@Override
	public String getNombre() {
		return "Listar Operaciones";
	}

	@Override
	public void ejecutar(Banco contexto) throws Exception {
		
		System.out.println("Listado de operacions");
		System.out.println();
	
		for (String operacion : registros) {
			System.out.println(operacion);
		}

	}
	
	public List<String> getRegistros() {
		return registros;
	}
	
	public void agregarRegistro(String op) {
		registros.add(op);
	}

}
