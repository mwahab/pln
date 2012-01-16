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
    admin_user = AdminUser.create!(:email => "admin@pln.com",
                      :password => "password",
                      :password_confirmation => "password")
    AdminUser.create!(:email => "admin2@pln.com",
                      :password => "password",
                      :password_confirmation => "password")

    10.times do 
      firstName  = Faker::Name.first_name
      lastName  = Faker::Name.last_name
      name = firstName + " " + lastName
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
      doctorPhone = Faker::PhoneNumber.phone_number
      emergency_contact_name = Faker::Name.name
      emergency_contact_phone = Faker::PhoneNumber.phone_number
      dateDiagnosis = DateTime.now - rand_int(10, 7300)
      placeDiagnosis = Faker::Address.city

      Member.create!(:firstName => firstName,
                     :lastName => lastName,
                     :name => name,
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
                     :methadone => rand(2) == 1,
                     :active => rand(2) == 1,
                     :doctor => doctor,
                     :doctorPhone => doctorPhone,
                     :emergency_contact_name => emergency_contact_name,
                     :emergency_contact_phone => emergency_contact_phone,
                     :dateDiagnosis => dateDiagnosis,
                     :placeDiagnosis => placeDiagnosis)

    end

    Member.all.each do |member|
      20.times do
        body = Faker::Lorem.paragraphs
        member.notes.create!(:admin_user_id => admin_user.id, :body => body)
      end

      20.times do
        body = Faker::Lorem.paragraph
        complete = rand(2) == 1
        duedate = rand(2) == 1 ? DateTime.now + rand_int(10, 7300) : nil
        member.goals.create!(:admin_user_id => admin_user.id, :body => body, :complete => complete, :duedate => duedate)
      end
    end
  end
end
