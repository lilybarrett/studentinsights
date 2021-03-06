require 'rails_helper'

RSpec.describe Importer do

  describe '#import' do

    let(:file_importer_class) { StudentsImporter }

    let(:file_importer) { file_importer_class.new }

    context 'CSV with 1 High School student, 1 Healey student (Elem), 1 Brown student (Elem)' do

      let(:fixture_path) { "#{Rails.root}/spec/fixtures/fake_students_export.txt" }
      let(:file) { File.open(fixture_path) }
      let(:transformer) { CsvTransformer.new }
      let(:csv) { transformer.transform(file) }

      context 'no scope' do
        let(:importer) { Importer.new(current_file_importer: file_importer) }
        it 'imports both students' do
          expect { importer.start_import(csv) }.to change(Student, :count).by 3
        end
      end

      context 'scope is Healey School' do
        let(:healey) { FactoryGirl.create(:healey) }
        let(:importer) { Importer.new(
            school_scope: [healey.local_id], current_file_importer: file_importer
          )
        }
        it 'only imports the Healey student' do
          expect { importer.start_import(csv) }.to change(Student, :count).by 1
        end
      end

    end
  end
end
