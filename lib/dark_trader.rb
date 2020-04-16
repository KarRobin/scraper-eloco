require 'nokogiri'
require 'open-uri'

def john_weak_trad
    url = "https://coinmarketcap.com/all/views/all/"
    page = Nokogiri::HTML(open(url)) 
    
    # Selectionner l'objet par sa classe la plus regressive, maper le texte dans un array
    print names = page.css("td.cmc-table__cell--left.cmc-table__cell--sort-by__name").map(&:text)
    sleep(1)
    p price = page.css("td.cmc-table__cell--sort-by__price").map(&:text)
    
    # Joindre les deux arrays en hash
    p names.zip(price).to_h

    # Gestion d'erreur
    return "probleme lentgh" if names.lentgh != price.lentgh
    
    


end

john_weak_trad