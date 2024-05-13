package farias.paulino.kauan.AvaliacaoLabBD_2.persistence;

import java.sql.SQLException;
import java.util.List;

public interface ICrudAluno<T> {
	public String inserir(T t) throws SQLException, ClassNotFoundException;
	public String atualizar(T t) throws SQLException, ClassNotFoundException;
	public T consultar(T t) throws SQLException, ClassNotFoundException;
	public List<T> listar() throws SQLException, ClassNotFoundException;
	public String GeraRa() throws SQLException, ClassNotFoundException;
}
