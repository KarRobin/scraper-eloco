require 'nokogiri'
require 'open-uri'

# Scrap dep de son choix
def scrap_choice
    p "Choisi le departement dont tu souhaites obtenir les emails des communes"
    nb_departement = gets.chomp.to_i

    page = Nokogiri::HTML(open("http://www.annuaire-des-mairies.com/#{nb_departement}/"))
    list_communes = page.css("pre/a").map(&:text).map{|x| x[0..-6]}
    list_communes.delete[1..6]

end

# Scrap Val d'Oise
def scrap_communes_list
    page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
    @list_communes = page.css("td/p/a").map(&:text).map!(&:downcase).each {
        |x| x.gsub!(/\s/, "-")}
end

def get_mail
    email_communes = Array.new
    # Appel liste des communues pour un passage en boucle
    scrap_communes_list.each {|city_name_formated|
        # Requete de la page pour la ville X
        page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/95/#{city_name_formated}.html"))

        # Affichage de la progression // option compteur ne fonctionne pas // affiche des emails non plus
        p "Stay Calm, Keep Cool... Sauvegarde des adresses emails (#{@list_communes.index(city_name_formated)}/#{@list_communes.length})"


        # Scrap de l'email sur la page de X
        # Stockage dans l'array email communes
        email_communes << page.css("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").map(&:text)
    }
    p email_communes
    p @list_communes.zip(email_communes).to_h
    
end

p scrap_choice