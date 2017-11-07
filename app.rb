require 'sinatra'
require 'httparty'
require 'nokogiri'
require 'uri'
require 'date'
require 'csv'

get '/' do
    send_file 'index.html'
end

get '/lunch' do
    @lunch = ["20층","김밥카페","순남시레기","시골집"]
    @photos = {
        "20층" => "https://scontent-sea1-1.cdninstagram.com/t51.2885-15/s750x750/sh0.08/e35/20987024_1431422050287339_2004189507347283968_n.jpg?ig_cache_key=MTU4NzUwMTg2NjEwNzc3MTI0Nw%3D%3D.2&se=5",
        "김밥카페" => "http://www.gimgane.co.kr/board/data/file/menu/1935589795_afscgN0k_EAB980EAB080EB84A4EAB980EBB0A5_EC8B9CEAB888ECB998_.jpg",
        "순남시레기" => "http://cfile25.uf.tistory.com/image/235FF03455A3421504721F",
        "시골집" => "https://igx.4sqi.net/img/general/200x200/V32AT15FO2J0E0EDEUPEAQ1P24ASEYCQIHM5WJV2XA2YFJAU.jpg"
    }
    erb :lunch
end

get '/lotto' do
    @lotto = (1..45).to_a.sample(6)
    erb :lotto
end

get '/welcome/:name' do
    "Welcome ! #{params[:name]}"
end

get '/lol' do
    erb :lol
end

get '/search' do
    
    url = "http://www.op.gg/summoner/userName="
    @id = params[:userName]
    keyword = URI.encode(@id)
    res = HTTParty.get(url + keyword)
    text = Nokogiri::HTML(res.body)
    @win = text.css('#SummonerLayoutContent > div.tabItem.Content.SummonerLayoutContent.summonerLayout-summary > div.SideContent > div.TierBox.Box > div.SummonerRatingMedium > div.TierRankInfo > div.TierInfo > span.WinLose > span.wins')
    @lose = text.css('#SummonerLayoutContent > div.tabItem.Content.SummonerLayoutContent.summonerLayout-summary > div.SideContent > div.TierBox.Box > div.SummonerRatingMedium > div.TierRankInfo > div.TierInfo > span.WinLose > span.losses')
    
    # File.open("log.txt", 'a+') do |f|
    #     f.write("#{@id}, #{@win.text}, #{@lose.text}, " + Time.now.to_s + "\n")
    # end
    
    CSV.open('log.csv', 'a+') do |csv|
        csv << [@id, @win.text, @lose.text, Time.now.to_s]
    end
    
    erb :search
end

get '/log' do
    @log = []
    CSV.foreach('log.csv') do |row|
        @log << row
    end
    erb :log
end    

get '/cube/:num' do
    input = params[:num].to_i
    result = input ** 3
    "The result is #{result}"
end