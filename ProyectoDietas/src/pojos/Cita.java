package pojos;

import java.sql.Date;

public class Cita {
	private int idMedicoPaciente;
	private int idCita;
	private Date fecha;
	private String observaciones;
	public int getIdMedicoPaciente() {
		return idMedicoPaciente;
	}
	public void setIdMedicoPaciente(int idMedicoPaciente) {
		this.idMedicoPaciente = idMedicoPaciente;
	}
	public int getIdCita() {
		return idCita;
	}
	public void setIdCita(int idCita) {
		this.idCita = idCita;
	}
	public Date getFecha() {
		return fecha;
	}
	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}
	public String getObservaciones() {
		return observaciones;
	}
	public void setObservaciones(String observaciones) {
		this.observaciones = observaciones;
	}
	
}
