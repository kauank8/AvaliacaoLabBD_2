package farias.paulino.kauan.AvaliacaoLabBD_2.persistence;

import java.sql.SQLException;
import java.util.List;

import farias.paulino.kauan.AvaliacaoLabBD_2.model.Disciplina;

public interface IDispensa <T>{
	
	public String solicitarDispensa(T d) throws SQLException, ClassNotFoundException;
	public List<T> acompanharDispensas(T d) throws SQLException, ClassNotFoundException;
	public List<Disciplina> listarDisciplina(T d) throws SQLException, ClassNotFoundException;
	public List<T> listarDispensas() throws SQLException, ClassNotFoundException;
	public List<T> filtrarDispensas(T d) throws SQLException, ClassNotFoundException;
	public String aceitar_recusar_dispensa(T d) throws SQLException, ClassNotFoundException;
}
