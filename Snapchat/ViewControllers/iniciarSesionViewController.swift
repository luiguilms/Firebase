//
//  ViewController.swift
//  Snapchat
//
//  Created by Luigui Lupacca on 7/11/23.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import FirebaseDatabase

class iniciarSesionViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var botonGoogle: UIButton!
    @IBAction func iniciarSesionTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
                if let error = error as NSError? {
                    print("Error al intentar iniciar sesión: \(error.localizedDescription)")

                    if error.code == AuthErrorCode.userNotFound.rawValue {
                        // El usuario no existe, muestra la alerta para crear uno nuevo
                        print("...")
                    } else {
                        // Otro tipo de error, muestra la alerta de error
                        self.mostrarAlertaError("Error de Inicio de Sesión", mensaje: error.localizedDescription)
                    }
                } else {
                    // Inicio de sesión exitoso
                    print("Inicio de sesión exitoso")
                    self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
                }
            }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func iniciarSesion() {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
                if let error = error as NSError? {
                    print("Error al intentar iniciar sesión: \(error.localizedDescription)")
                    self.mostrarAlertaError("Error de Inicio de Sesión", mensaje: error.localizedDescription)
                } else {
                    // Inicio de sesión exitoso
                    print("Inicio de sesión exitoso")
                    self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
                }
            }
        }
        
    func mostrarAlertaError(_ titulo: String, mensaje: String) {
        let alerta = UIAlertController(title: "Usuario no Existente", message: "El usuario no existe. ¿Desea crear uno nuevo?", preferredStyle: .alert)
        let btnCrear = UIAlertAction(title: "Crear", style: .default) { (_) in
            // Redirige a la vista para crear un nuevo usuario
            self.performSegue(withIdentifier: "segueCrearUsuario", sender: nil)
        }
        let btnCancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alerta.addAction(btnCrear)
        alerta.addAction(btnCancelar)
        present(alerta, animated: true, completion: nil)
    }

    
}

