require 'xcodeproj'

project_path = 'Demo-Speckit-messageApp.xcodeproj'
source_folder = 'Views'

project = Xcodeproj::Project.open(project_path)
group = project.main_group.find_subpath(source_folder, true)

Dir.glob("#{source_folder}/*.swift").each do |file|
  unless group.files.find { |f| f.path == file }
    group.new_file(file)
    puts "Added: #{file}"
  end
end

project.save
puts "Project updated!"
