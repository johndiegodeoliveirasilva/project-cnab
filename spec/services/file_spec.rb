require 'rails_helper'

RSpec.describe Valid::Files, type: :service do
  describe "valid file cnab" do
    let(:cnabs_correct) { "3201903010000014200058496701224753****3153153453JOÃO MACEDO   BAR DO JOÃO        " }
    let(:cnabs_cpf_incorret) { "2201903010000010700345152540738723****9987123333MARCOS PEREIRAMERCADO DA AVENIDA " }
    let(:cnabs_many_lines) { "3201903010000014200096206760174753****3153153453JOÃO MACEDO   BAR DO JOÃO       \n" \
                            "5201903010000013200556418154633123****7687145607MARIA JOSEFINALOJA DO Ó - MATRIZ "}
    let(:cnabs_value_zero) { "3201903010000000000058496701224753****3153153453JOÃO MACEDO   BAR DO JOÃO        " }
    it "line correct" do
      response = Valid::Files.run(cnabs_correct)
      expect(response).to eq(true)
    end

    it "cpf incorrect in line 1" do
      response = Valid::Files.run(cnabs_cpf_incorret)
      expect(response).to eq("Erro na verificação, na linha 1 contem errors, na posição 20..30")
    end

    it "when exist error in line 2 and cpf" do
      response = Valid::Files.run(cnabs_many_lines)
      expect(response).to eq("Erro na verificação, na linha 2 contem errors, na posição 20..30")
    end

    it "when the number of columns is less than 81" do
      response = Valid::Files.run(cnabs_many_lines.delete(" "))
      expect(response).to eq("Arquivo corrumpido.")
    end

    it "when value cash is less than 0.0" do
      response = Valid::Files.run(cnabs_value_zero)
      expect(response).to eq("Erro na verificação, na linha 1 contem errors, na posição 10..19")
    end

    it "when the operation type is a letter" do
      cnabs_correct[0] = 'a'
      response = described_class.run(cnabs_correct)
      expect(response).to eq("Erro na verificação, na linha 1 contem errors, na posição 1")
    end
  end
end
