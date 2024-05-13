package farias.paulino.kauan.AvaliacaoLabBD_2.controller;

import java.sql.SQLException;
import java.time.LocalDate;
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
import farias.paulino.kauan.AvaliacaoLabBD_2.model.Curso;
import farias.paulino.kauan.AvaliacaoLabBD_2.persistence.AlunoDao;
@Controller
public class SecretariaController {
	@Autowired
	private AlunoDao aDao;

	@RequestMapping(name = "secretaria", value = "/secretaria", method = RequestMethod.GET)
	public ModelAndView SecretariaGet(ModelMap model) {
		return new ModelAndView("secretaria");
	}

	@RequestMapping(name = "secretaria", value = "/secretaria", method = RequestMethod.POST)
	public ModelAndView SecretariaPost(@RequestParam Map<String, String> param, ModelMap model) {

		// Entrada
		String cmd = param.get("botao");
		String cod_curso = param.get("codigo_curso");
		String cpf = param.get("cpf");
		String nome = param.get("nome");
		String nome_social = param.get("nome_social");
		String data_nasc = param.get("data_nasc");
		String conclusao = param.get("conclusao_segundo_grau");
		String email_pessoal = param.get("email_pessoal");
		String email_corporativo = param.get("email_corporativo");
		String instituicao = param.get("instituicao_segundo_grau");
		String pontuacao = param.get("pontuacao_vestibular");
		String posicao = param.get("posicao_vestibular");
		String ra = "";

		// Retorno
		String saida = "";
		String erro = "";
		Aluno a = new Aluno();
		List<Aluno> alunos = new ArrayList<>();

		if (cmd.contains("Cadastrar")) {
			if (cpf.isEmpty() || nome.isEmpty() || data_nasc.isEmpty() || conclusao.isEmpty() || email_pessoal.isEmpty()
					|| email_corporativo.isEmpty() || instituicao.isEmpty() || pontuacao.isEmpty() || posicao.isEmpty()
					|| cod_curso.isEmpty()) {
				saida = "Todos campos são obrigatórios, com excessão de nome social";
			} else {
				a.setCpf(cpf);
				a.setNome(nome);
				a.setNome_social(nome_social);
				a.setData_nasc(LocalDate.parse(data_nasc));
				a.setConclusao_segundo_grau(LocalDate.parse(conclusao));
				a.setEmail_pessoal(email_pessoal);
				a.setEmail_corporativo(email_corporativo);
				a.setInstituicao_segundo_grau(instituicao);
				a.setPontuacao_vestibular(Double.parseDouble(pontuacao));
				a.setPosicao_vestibular(Integer.parseInt(posicao));
				Curso c = new Curso();
				c.setCodigo(Integer.parseInt(cod_curso));
				a.setCurso(c);
			}
		}
		try {
			if (cmd.contains("Cadastrar")) {
				if (cpf.isEmpty() || nome.isEmpty() || data_nasc.isEmpty() || conclusao.isEmpty()
						|| email_pessoal.isEmpty() || email_corporativo.isEmpty() || instituicao.isEmpty()
						|| pontuacao.isEmpty() || posicao.isEmpty()) {
					saida = "Todos campos são obrigatórios, com excessão de nome social";
				} else {
					a.setRa(geraRa());
					saida = cadastrarAluno(a);
					if (saida.contains("Aluno cadastrado com sucesso")) {
						saida += ", Ra Gerado: " + a.getRa();
					}
					a = null;
				}
			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("aluno", a);
			model.addAttribute("alunos", alunos);

			return new ModelAndView("secretaria");
		}
	}
	
	private String geraRa() throws ClassNotFoundException, SQLException {
		String saida = aDao.GeraRa();
		return saida;
	}

	private String cadastrarAluno(Aluno a) throws ClassNotFoundException, SQLException {
		String saida = aDao.inserir(a);
		return saida;
	}

}
