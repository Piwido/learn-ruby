# frozen_string_literal: true

require 'hexapdf'
require 'fileutils'
require 'pry'

class PDFcleaner
  attr_reader :output_directory, :input_directory

  def initialize(input_directory, output_directory = './clean_files')
    @input_directory = input_directory
    @output_directory = output_directory
    FileUtils.mkdir_p(output_directory)
  end

  def process_files
    Dir.glob(File.join(input_directory, '*.pdf')).each do |pdf_file|
      puts "Processing #{pdf_file}..."
      process_pdf(pdf_file)
    end
  end

  private

  def process_pdf(pdf_file)
    pdf = open_pdf(pdf_file)
    begin
      pdf.each do |obj|
        next unless obj.value.is_a?(Hash)

        process_object(obj)
      end
    rescue HexaPDF::Error => e
      puts "Error processing PDF file: #{e.message}"
    end
    save_pdf(pdf, File.join(output_directory, File.basename(pdf_file)))
  end

  def open_pdf(file_path)
    HexaPDF::Document.open(file_path)
  rescue HexaPDF::Error => e
    puts "Error opening PDF file: #{e.message}"
  end

  def process_object(obj)
    case obj[:Type]
    when :Catalog
      remove_open_action(obj) if obj[:OpenAction]
    when :Action
      remove_js_action(obj) if obj[:S] == :JavaScript
    when :Annot
      remove_js_annot(obj) if obj[:A] && obj[:A][:S] == :Widget
    when :Font
      remove_font_matrix(obj) if obj.key?(:FontMatrix) && corrupt_font_matrix?(obj)
    end
  end

  def remove_open_action(obj)
    puts "OpenAction object found in object: #{obj[:OpenAction]} - deleting..."
    obj.delete(:OpenAction)
  end

  def remove_js_action(obj)
    puts "JavaScript object found in Action object: #{obj[:JS]} - deleting..."
    obj.document.delete(obj)
  end

  def remove_js_annot(obj)
    puts "JavaScript object found in Annot object: #{obj[:A][:JS]} - deleting..."
    obj.document.delete(obj)
  end

  def corrupt_font_matrix?(obj)
    font_matrix = if obj[:FontMatrix].respond_to?(:value)
                    obj[:FontMatrix].value
                  else
                    obj[:FontMatrix]
                  end
    puts "FontMatrix object found : #{font_matrix}"
    font_matrix.any? { |n| !n.is_a?(Numeric) }
  end

  def remove_font_matrix(obj)
    obj.delete(:FontMatrix)
  end

  def save_pdf(pdf, output_path)
    # TO DO : en profite t'on pour compresser ?
    pdf.write(output_path, optimize: false, validate: false)
  end
end

cleaner = PDFcleaner.new('./infected_files')
cleaner.process_files
