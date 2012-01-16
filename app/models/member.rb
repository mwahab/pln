class Member < ActiveRecord::Base
  # constants
  GENDERS = ['MALE', 'FEMALE', 'TRANSGENDER', 'OTHER']
  DIAGNOSES = ['HIV+', 'AIDS', 'HIV+ & Hep C']
  ETHNICITIES = ['ABORIGINAL', 'STATUS', 'NON-ABORIGINAL', 'UNDISCLOSED']
  PROVINCES = ['ALBERTA', 'BRITISH COLUMBIA', 'MANITOBA', 'NEW BRUNSWICK', 'NEWFOUNDLAND AND LABRADOR', 'NOVA SCOTIA', 'ONTARIO', 'PRINCE EDWARD ISLAND', 'QUEBEC', 'SASKATCHEWAN', 'NORTHWEST TERRITORIES', 'NUNAVUT', 'YUKON']

  has_many :notes, :dependent => :destroy
  has_many :goals, :dependent => :destroy

  attr_accessible :firstName, :lastName, :name, :birthdate, :gender, :address, :city, :province, :postalCode, :telephone, :carecard, :sin, :ethnicity, :diagnosis, :arv, :arvDate, :doctor, :doctorPhone, :placeDiagnosis, :dateDiagnosis, :active, :methadone, :emergency_contact_name, :emergency_contact_phone

  validates :firstName, :lastName, :name, :gender, :ethnicity, :diagnosis, :presence => true
  validates :gender, :inclusion => { :in => GENDERS }
  validates :ethnicity, :inclusion => { :in => ETHNICITIES }
  validates :diagnosis, :inclusion => { :in => DIAGNOSES }

  scope :incomplete_files, lambda {
    where("name IS NULL OR gender IS NULL OR ethnicity IS NULL OR diagnosis IS NULL OR sin IS NULL OR address IS NULL OR birthdate IS NULL OR province IS NULL OR postalCode IS NULL OR telephone IS NULL OR carecard IS NULL OR doctor IS NULL OR doctorPhone IS NULL") 
  }
end
