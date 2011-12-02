def rand_in_range(from, to)
  rand * (to - from) + from
end

def rand_int(from, to)
  rand_in_range(from, to).to_i
end

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    AdminUser.create!(:email => "admin@pln.com",
                 :password => "password",
                 :password_confirmation => "password")
    AdminUser.create!(:email => "admin2@pln.com",
                 :password => "password",
                 :password_confirmation => "password")

    99.times do |n|
      firstName  = Faker::Name.first_name
      lastName  = Faker::Name.last_name
      birthdate = DateTime.now - rand_int(7300, 21900)
      gender = Member::GENDERS.sample
      address = Faker::Address.street_address
      city = Faker::Address.city
      province = Member::PROVINCES.sample
      postalCode = Faker::Address.postcode
      telephone = Faker::PhoneNumber.phone_number
      carecard = (0...8).map{65.+(rand(25))}.join
      sin = (0...8).map{65.+(rand(25))}.join
      ethnicity = Member::ETHNICITIES.sample
      diagnosis = Member::DIAGNOSES.sample
      arv = [true, false].sample
      arvDate = DateTime.now - rand_int(10, 7300)
      doctor = Faker::Name.name
      dentist = Faker::Name.name
      doctorPhone = Faker::PhoneNumber.phone_number
      dentistPhone = Faker::PhoneNumber.phone_number
      dateDiagnosis = DateTime.now - rand_int(10, 7300)
      placeDiagnosis = Faker::Address.city

      Member.create!(:firstName => firstName,
                     :lastName => lastName,
                     :birthdate => birthdate,
                     :gender => gender,
                     :address => address,
                     :city => city,
                     :province => province,
                     :postalCode => postalCode,
                     :telephone => telephone,
                     :carecard => carecard,
                     :sin => sin,
                     :ethnicity => ethnicity,
                     :diagnosis => diagnosis,
                     :arv => arv,
                     :arvDate => arvDate,
                     :doctor => doctor,
                     :doctorPhone => doctorPhone,
                     :dentist => dentist,
                     :dentistPhone => dentistPhone,
                     :dateDiagnosis => dateDiagnosis,
                     :placeDiagnosis => placeDiagnosis)
    end
  end
end
