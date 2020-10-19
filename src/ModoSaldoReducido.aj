import ejemplo.cajero.modelo.Cuenta;

public aspect ModoSaldoReducido {
	
	pointcut retirar() : call( void ejemplo.cajero.modelo.Cuenta.retirar(long));
	
	void around(Cuenta c, long valor) throws Exception: retirar() && target(c) && args(valor) {

		if (c.getSaldo()- valor < 200000) {
			throw new Exception("Se debe tener al menos 200 mil");
		}
		System.out.println("Holaaaa");
		proceed(c, valor);
	}
}