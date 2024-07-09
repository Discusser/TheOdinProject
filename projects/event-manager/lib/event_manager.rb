require "csv"
require "google/apis/civicinfo_v2"
require "erb"

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, "0")[0..4]
end

def clean_phone_number(phone_number)
  stripped = phone_number.gsub(/[().\- ]/, "")
  digits = stripped.scan(/\d/).size
  if digits > 11 && phone_number.starts_with?("1")
    stripped[1..]
  elsif digits == 10
    stripped
  end
end

def legislators_by_zipcode(zipcode) # rubocop:disable Metrics/MethodLength
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = File.read("secret.key").strip

  begin
    civic_info.representative_info_by_address(
      address: zipcode,
      levels: "country",
      roles: %w[legislatorUpperBody legislatorLowerBody]
    ).officials
  rescue StandardError
    "You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials"
  end
end

def parse_date(date)
  # 11/25/08 19:21
  DateTime.strptime(date, "%D %R")
end

def save_thank_you_letter(id, form_letter)
  FileUtils.mkdir_p("output")

  filename = "output/thanks_#{id}.html"
  File.write(filename, form_letter)
end

puts "Event Manager initialized!"

contents = CSV.open("event_attendees.csv", headers: true, header_converters: :symbol)

template_letter = File.read("form_letter.erb")
erb_template = ERB.new(template_letter)

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  phone_number = clean_phone_number(row[:homephone])
  registration_date = parse_date(row[:regdate])
  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)
  save_thank_you_letter(id, form_letter)
end
