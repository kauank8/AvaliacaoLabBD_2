package farias.paulino.kauan.AvaliacaoLabBD_2.persistence;

import java.sql.SQLException;
import java.util.List;

import farias.paulino.kauan.AvaliacaoLabBD_2.model.Aluno;
import farias.paulino.kauan.AvaliacaoLabBD_2.model.Matricula;

public interface IHistorico {
	public List<Matricula> buscar_historico(Aluno a) throws SQLException, ClassNotFoundException;
}
