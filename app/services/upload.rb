class Upload

  # Step 1 : it creates array of hash from uploaded file
  # Step 2 : it creates a new csv file with different fields

def self.import_data(params)


    if (params[:file_data]).nil?
      raise("Please upload a file.")
    elsif (params[:file_data]).content_type != "text/csv"
      raise("File type must be csv: #{(params[:file_data]).original_filename}")
    end

    items = []

    CSV.foreach((params[:file_data]).path, headers: true) do |row|

      my_array = row.to_s.split(".")
      first_name = my_array[0]
      last_name = (my_array[1]).split("@")[0]
      email = row.to_h['email']

      my_hash = { 'first_name'   => first_name,
                  'last_name'    => last_name,
                  'email'        => email }

      items << my_hash

    end

    self.create_csv(items)

  end

  def self.create_csv(items)

    file = "#{Rails.root}/tmp/result.csv"

    headers = ["first_name", "last_name", "scope_id", "email"]

    CSV.open(file, 'w', write_headers: true, headers: headers) do |writer|
      items.each do |item|
        writer << [(item['first_name']).capitalize, (item['last_name']).upcase, SCOPE_ID, (item['email']).downcase]
      end
    end

  end

end