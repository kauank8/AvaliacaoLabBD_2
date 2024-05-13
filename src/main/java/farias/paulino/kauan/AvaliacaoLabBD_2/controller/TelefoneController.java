package farias.paulino.kauan.AvaliacaoLabBD_2.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import farias.paulino.kauan.AvaliacaoLabBD_2.model.Aluno;
import farias.paulino.kauan.AvaliacaoLabBD_2.model.Telefone;
import farias.paulino.kauan.AvaliacaoLabBD_2.persistence.TelefoneDao;
import jakarta.servlet.RequestDispatcher;

@Controller
public class TelefoneController {
	@Autowired
	private TelefoneDao tDao;

	@RequestMapping(name = "telefone", value = "/telefone", method = RequestMethod.GET)
	public ModelAndView TelefoneGet(ModelMap model) {
		return new ModelAndView("telefone");
	}

	@RequestMapping(name = "telefone", value = "/telefone", method = RequestMethod.POST)
	public ModelAndView TelefonePost(@RequestParam Map<String, String> param, ModelMap model) {

		// Entrada
		String cmd = param.get("botao");
		String ra = param.get("ra");
		String numero = param.get("numero");
		String numero_novo = param.get("numero_novo");
		String numero_antigo = param.get("numero_antigo");

		// Retorno
		String saida = "";
		String erro = "";
		Telefone tel = new Telefone();
		List<Telefone> telefones = new ArrayList<>();

		// Objetos

		if (!ra.isEmpty()) {
			Aluno a = new Aluno();
			a.setRa(ra);
			tel.setAluno(a);
		}

		if (cmd.contains("Cadastrar") || cmd.contains("Excluir")) {
			tel.setNumero(numero);
		}

		if (cmd.contains("Alterar")) {
			tel.setNumero(numero_novo);
		}

		try {
			if (cmd.contains("Cadastrar")) {
				if (numero.isEmpty() || ra.isEmpty()) {
					saida = "Preencha todos os campos referente a Cadastrar";
				} else {
					saida = cadastrarTelefone(tel);
					tel = null;
				}
			}

			if (cmd.contains("Alterar")) {
				if (numero_novo.isEmpty() || ra.isEmpty() || numero_antigo.isEmpty() || numero_novo.isEmpty()) {
					saida = "Preencha todos os campos referente a Alterar";
				} else {
					Telefone tel_antigo = new Telefone();
					tel_antigo.setNumero(numero_antigo);
					saida = alterarTelefone(tel, tel_antigo);
					tel = null;
				}
			}
			if (cmd.contains("Excluir")) {
				if (numero.isEmpty() || ra.isEmpty()) {
					saida = "Preencha todos os campos referente a Excluir";
				} else {
					saida = excluirTelefone(tel);
					tel = null;
				}
			}
			if (cmd.contains("Listar")) {
				if (ra.isEmpty()) {
					saida = "Preencha o ra do aluno que deseja listar os telefones";
				} else {
					telefones = listarTelefone(tel);
					tel = null;
				}
			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
			tel = null;
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("telefone", tel);
			model.addAttribute("telefones", telefones);

			return new ModelAndView("telefone");
		}
	}
	
	private List<Telefone> listarTelefone(Telefone tel) throws ClassNotFoundException, SQLException {
		List<Telefone> lista = new ArrayList<>();
		lista = tDao.listar(tel);
		return lista;
	}

	private String excluirTelefone(Telefone tel) throws ClassNotFoundException, SQLException {
		String saida = tDao.exclui(tel);
		return saida;
	}

	private String alterarTelefone(Telefone tel, Telefone tel_antigo) throws ClassNotFoundException, SQLException {
		String saida = tDao.atualizar(tel, tel_antigo);
		return saida;
	}

	private String cadastrarTelefone(Telefone tel) throws ClassNotFoundException, SQLException {
		String saida = tDao.inserir(tel);
		return saida;
	}

}
