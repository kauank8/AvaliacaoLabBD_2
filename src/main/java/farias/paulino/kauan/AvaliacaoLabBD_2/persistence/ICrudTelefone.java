package farias.paulino.kauan.AvaliacaoLabBD_2.persistence;

import java.sql.SQLException;
import java.util.List;

import farias.paulino.kauan.AvaliacaoLabBD_2.model.Telefone;

public interface ICrudTelefone {
	public String inserir(Telefone t) throws SQLException, ClassNotFoundException;
	public String atualizar(Telefone tel_novo, Telefone tel_antigo) throws SQLException, ClassNotFoundException;
	public String exclui(Telefone t) throws SQLException, ClassNotFoundException;
	public List<Telefone> listar(Telefone t) throws SQLException, ClassNotFoundException;
}
