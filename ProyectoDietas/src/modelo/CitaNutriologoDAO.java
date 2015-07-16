package modelo;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import pojos.Cita;

public class CitaNutriologoDAO {
	private ConexionBD con = ConexionBD.getInstance();
	public ArrayList<Cita> obtenerCitas(int idMedPac){
		ArrayList<Cita> citas=new ArrayList<Cita>(); 
		String query="SELECT idCita,fecha,hora,observaciones FROM citas WHERE idMedicoPaciente = ? AND fecha>=current_date() ORDER BY fecha DESC";
		PreparedStatement prepStmt;
		try {
			prepStmt = con.builldPreparedStatement(query);
			prepStmt.setString(1, String.valueOf(idMedPac));
			ResultSet rs = prepStmt.executeQuery();

			while(rs.next()){
				Cita c= new Cita();
				c.setIdCita(Integer.parseInt(rs.getString("idCita")));
				c.setIdMedicoPaciente(idMedPac);
				c.setFecha(Date.valueOf(rs.getString("fecha")));
				c.setObservaciones(rs.getString("observaciones"));
				citas.add(c);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
		return citas;
	}
}
