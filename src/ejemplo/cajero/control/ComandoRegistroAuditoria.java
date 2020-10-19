package ejemplo.cajero.control;

import java.io.FileWriter;
import java.util.ArrayList;
import java.util.List;

import ejemplo.cajero.modelo.Banco;
import ejemplo.cajero.modelo.Cuenta;

/**
 * Comando usado para listar las cuentas 
 */
public class ComandoRegistroAuditoria implements Comando {

	private List<String> registros = new ArrayList<String>();
	
	@Override
	public String getNombre() {
		return "Generar archivo auditoría";
	}

	@Override
	public void ejecutar(Banco contexto) throws Exception {
		
		System.out.println("Guardando registro de auditoría");
		System.out.println();
	
		FileWriter myWriter = new FileWriter("registro.txt");
		for (String operacion : registros) {
			myWriter.write(operacion + "\n");
		}
		myWriter.close();
	}
	
	public List<String> getRegistros() {
		return registros;
	}
	
	public void agregarRegistro(String op) {
		registros.add(op);
	}

}
