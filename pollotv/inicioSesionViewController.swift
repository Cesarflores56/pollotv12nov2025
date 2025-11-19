//
//  inicioSesionViewController.swift
//  pollotv
//
//  Created by ALUMNOS on 10/11/25.
//

import UIKit
var nombreGlobal = ""
var posicionarregloGlobal = 0
var arreglonombre: [String] = ["cesar", "fatima", "michelle"]
var arreglocorreo: [String] = ["cesar@gmail.com", "fatima@gmail.com", "michelle@gmail.com"]
var arreglocontraseña: [String] = ["1234", "5678", "9012"]
var arreglopermiso: [String] = ["usuario", "usuario", "usuario"]
class inicioSesionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var Usuario: UITextField!
    
    @IBOutlet weak var Contraseña: UITextField!
    @IBOutlet weak var BotonEntrar: UIButton!
    @IBOutlet weak var ojito: UIButton!
    var cuentaUsuaruio = ""
    var cuentaContraseña = ""
    var timer = Timer()
    var intetos = 0
    var segundos = 0
    @IBAction func botonLogin(_ sender: UIButton) {
        
        if (verificadorArreglos()){
            
            if (arreglopermiso[posicionarregloGlobal] == "usuario"){
                self.performSegue(withIdentifier: "Inicio", sender: InicioViewController.self)
                
            }else{
                if (intetos >= 3 ){ displayErrorsegundo()
                }else{
                    displayError()
                    intetos = intetos + 1
                }
            }
        }
    }
            func verificarAccesos()->Bool{
                var validar = false
                cuentaUsuaruio = Usuario.text ?? ""
                cuentaContraseña = Contraseña.text ?? ""
                
                if (cuentaUsuaruio == "cesar@gmail.com" && cuentaContraseña == "1234"){
                    validar = true
                    nombreGlobal = "Cesar"
                    
                } else if(cuentaUsuaruio == "fatima@gmail.com" && cuentaContraseña == "5678"){
                    validar = true
                    nombreGlobal = "Fatima"
                    
                }
                
                return validar
                
            }
    
    func verificadorArreglos()->Bool{
        var validar = false
        cuentaUsuaruio = Usuario.text ?? ""
        cuentaContraseña = Contraseña.text ?? ""
        var contador = 0
        while (contador < arreglocorreo.count){
            if (arreglocorreo[contador] == cuentaUsuaruio && arreglocontraseña[contador] == cuentaContraseña){
                validar = true
                posicionarregloGlobal = contador
                break
            }
            contador += 1
        }
        
        
        return validar
    }
    
            func displayError(){
                var mensaje = "Error en usuario o contraseña"
                
                let alert = UIAlertController(title: "Error", message: mensaje, preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "Aceptar", style: .default, handler: ayudaError(_:))
                
                alert.addAction(dismissAction)
                
                present(alert, animated: true, completion: nil)
                
            }
            func displayErrorsegundo(){
                var mensaje = "Sistema bloqueado por numero de intentos fallidos"
                
                let alert = UIAlertController(title: "AYUDA", message: mensaje, preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "OK", style: .default, handler: ayudaErrorsegundo(_:))
                
                alert.addAction(dismissAction)
                
                present(alert, animated: true, completion: nil)
                
            }
            func ayudaError(_ action: UIAlertAction){
                Usuario.text = ""
                Contraseña.text = ""
                
            }
            func ayudaErrorsegundo(_ action: UIAlertAction){
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(inicioSesionViewController.action), userInfo: nil, repeats: true)
                Usuario.text = ""
                Contraseña.text = ""
                Usuario.isEnabled = false
                Contraseña.isEnabled = false
                BotonEntrar.isEnabled = false
            }
    @objc func action(){
        if (segundos >= 15){
            Usuario.isEnabled = true
            Contraseña.isEnabled = true
            BotonEntrar.isEnabled = true
            timer.invalidate()
            displayDesbloqueo()
            segundos = 0
            intetos = 0
        }
        segundos += 1
    }
    func displayDesbloqueo(){
        var mensaje = "desbloqueando sistema"
        
        let alert = UIAlertController(title: "Aviso", message: mensaje, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: ayudaDesbloqueo(_:))
        
        alert.addAction(dismissAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    func ayudaDesbloqueo (_ action: UIAlertAction){
        Contraseña.text = ""
        Usuario.text = ""
        segundos = 0
        BotonEntrar.isEnabled = true
    }
            func displayError1(_ sender: UIButton){
                
            }
        
    
    @IBAction func Ojo(_ sender: UIButton) {
        if (Contraseña.isSecureTextEntry == true){
            Contraseña.isSecureTextEntry = false
            ojito.setImage(UIImage(systemName: "eye"), for: .normal)
            
        }else{ Contraseña.isSecureTextEntry = true
            ojito.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            
        }
    }
}
