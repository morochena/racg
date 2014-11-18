require 'sinatra'
require 'prawn'

get '/' do 
  erb :index
end

get '/report' do 
  content_type 'application/pdf'

  reptype = params[:covertype]
  repname = params[:title]
  repmonth = params[:month]
  repyear = params[:year]


  pdf = Prawn::Document.new
      #header
      pdf.image "public/assets/header.png", position: :center, scale: 0.48
      pdf.move_down 100

      #production risk summary
      pdf.font "public/assets/Arial Black.ttf"
      pdf.text params[:covertype], align: :center, size: 28
      pdf.move_down 40

      #report title
      pdf.text "\"#{repname}\"", align: :center, size: 24, color: "02305E", leading: 20

      #address
      pdf.font "Helvetica"
      pdf.text_box "11 North Washington Street", at: [0, 100]
      pdf.text_box "Suite 350", at: [0, 85]
      pdf.text_box "Rockville, Maryland 20850", at: [0, 70]
      pdf.text_box "Tel:  301-279-6700", at: [0, 55]
      pdf.text_box "Fax: 301-251-0670", at: [0, 40]
      pdf.formatted_text_box [text: "www.prudentrisk.com", styles: [:bold], color: "911B19" ], at: [0, 25]

      #date
      pdf.font "public/assets/Arial Black.ttf"
      pdf.formatted_text_box [ text: "CONFIDENTIAL", size: 20, color: "911B19" ], at: [370, 25]
      pdf.text_box "#{repmonth} #{repyear}", at: [418, 50], size: 16
    
  pdf.render
end 