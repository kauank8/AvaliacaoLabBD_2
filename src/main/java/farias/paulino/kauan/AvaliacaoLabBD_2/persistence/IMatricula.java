package farias.paulino.kauan.AvaliacaoLabBD_2.persistence;

import java.sql.SQLException;
import java.util.List;

import farias.paulino.kauan.AvaliacaoLabBD_2.model.Disciplina;
import farias.paulino.kauan.AvaliacaoLabBD_2.model.Matricula;

public interface IMatricula {
	public String inserir(Matricula m) throws SQLException, ClassNotFoundException;
	public List<Disciplina> listarDisciplinas(Matricula m) throws SQLException, ClassNotFoundException;
	public List<Matricula> listarMatriculas(Matricula m) throws SQLException, ClassNotFoundException;
}
