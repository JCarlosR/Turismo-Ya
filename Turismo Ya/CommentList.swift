//
//  CommentList.swift
//  Turismo Ya
//
//  Created by rimenri on 05/05/2017.
//  Copyright © 2017 Programación y más. All rights reserved.
//

import UIKit

class CommentList: NSObject {
    
    var commentsTableView: UITableView?
    
    var comments: [Comment] = []
    
    func addComment(comment: Comment) {
        comments.append(comment)
    }
    
    func clearComments() {
        comments.removeAll()
    }
}

extension CommentList: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Formato de celda
        let cell = Bundle.main.loadNibNamed("CommentTableViewCell", owner: self, options: nil)?.first as! CommentTableViewCell
        
        // Datos del comentario con índice row
        let comment = comments[indexPath.row]
        
        // Asignamos los valores a la celda y la devolvemos luego
        // let imageUrl = URL(string: "http://52.170.87.192:50/premiun/images/categories/\(category.imageUrl)")
        // cell.categoryImageView.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "logo.png"), options: SDWebImageOptions.progressiveDownload)
        cell.labelAuthorName.text = comment.navegante
        cell.labelDate.text = comment.fecha
        cell.labelComment.text = comment.comentario
        
        // metadata
        // cell.stars = comment.valor
        cell.paintStarsUpTo(stars: Int(comment.valor)!)
        
        return cell
        
        // Podemos incluso usar 2 formatos distintos de tableViewCell
        // para ello, en base a 1 atributo cell podemos decidir qué nib vamos a usar
        // Custom table view tutorial: https://www.youtube.com/watch?v=zAWO9rldyUE
        // Si estos nib tienen alturas distintas, entonces hay que sobreescribir un método más
        // en esta implementacóìn de UITableViewDataSource, para tener acceso a definir
        // la altura de nuestras celdas.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // nothing to do here
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 102 }
}

