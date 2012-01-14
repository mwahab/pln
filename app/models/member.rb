class Member < ActiveRecord::Base
  # constants
  GENDERS = ['MALE', 'FEMALE', 'TRANSGENDER', 'OTHER']
  DIAGNOSES = ['HIV+', 'AIDS', 'HIV+ & Hep C']
  ETHNICITIES = ['ABORIGINAL', 'STATUS', 'NON-ABORIGINAL', 'UNDISCLOSED']
  PROVINCES = ['ALBERTA', 'BRITISH COLUMBIA', 'MANITOBA', 'NEW BRUNSWICK', 'NEWFOUNDLAND AND LABRADOR', 'NOVA SCOTIA', 'ONTARIO', 'PRINCE EDWARD ISLAND', 'QUEBEC', 'SASKATCHEWAN', 'NORTHWEST TERRITORIES', 'NUNAVUT', 'YUKON']

  has_many :notes, :dependent => :destroy
  has_many :goals, :dependent => :destroy

  attr_accessible :firstName, :lastName, :name, :birthdate, :gender, :address, :city, :province, :postalCode, :telephone, :carecard, :sin, :ethnicity, :diagnosis, :arv, :arvDate, :doctor, :dentist, :doctorPhone, :dentistPhone, :placeDiagnosis, :dateDiagnosis, :active, :methadone, :emergency_contact_name, :emergency_contact_phone

  validates :firstName, :lastName, :name, :gender, :ethnicity, :diagnosis, :presence => true
  validates :gender, :inclusion => { :in => GENDERS }
  validates :ethnicity, :inclusion => { :in => ETHNICITIES }
  validates :diagnosis, :inclusion => { :in => DIAGNOSES }

  def incomplete?
    self.attributes.values.any? { |v| v.nil? }
  end
end
