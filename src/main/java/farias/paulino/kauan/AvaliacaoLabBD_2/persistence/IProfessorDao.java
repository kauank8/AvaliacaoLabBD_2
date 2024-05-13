package farias.paulino.kauan.AvaliacaoLabBD_2.persistence;

import java.sql.SQLException;
import java.util.List;

import farias.paulino.kauan.AvaliacaoLabBD_2.model.Chamada;
import farias.paulino.kauan.AvaliacaoLabBD_2.model.Disciplina;
import farias.paulino.kauan.AvaliacaoLabBD_2.model.Matricula;
import farias.paulino.kauan.AvaliacaoLabBD_2.model.Professor;

public interface IProfessorDao {

	public List<Disciplina> listar_disciplinas(Professor p) throws SQLException, ClassNotFoundException;
	public List<Chamada> listar_chamada(Disciplina d) throws SQLException, ClassNotFoundException;
	public Object[] listar_alunosChamada(Disciplina d) throws SQLException, ClassNotFoundException;
	public String inserir_chamada(Chamada cm) throws SQLException, ClassNotFoundException;
	public List<Chamada> lista_editar_chamada(Chamada cm) throws SQLException, ClassNotFoundException;
	public String atualizar_chamada (Chamada cm) throws SQLException, ClassNotFoundException;
}
