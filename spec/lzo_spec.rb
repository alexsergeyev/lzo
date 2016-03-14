require 'spec_helper'

describe LZO do
  context 'files generated by lzop CLI' do
    it 'decompresses a long (multi block) utf8 file' do
      original = File.read fixture_path 'long_utf8_plaintext.txt'
      compressed = File.binread fixture_path 'long_utf8_plaintext.txt.lzo'
      decompressed = LZO.decompress compressed
      expect(decompressed).to eq(original)
    end

    xit 'decompresses a short utf8 (single block) file'
    xit 'decompresses a compressible binary file'

    it 'decompresses an incompressible binary file' do
      original = File.binread fixture_path 'incompressible.zip'
      compressed = File.binread fixture_path 'incompressible.zip.lzo'
      decompressed = LZO.decompress compressed
      expect(decompressed).to eq(original)
    end

    xit 'raises an error for invalid data'
    xit 'decompresses a file with method 2 (level 1-15)'
    xit 'decompresses a file with method 3 (level 999)'
    xit 'validates an adler32 checksum'
    xit 'validates an crc32 checksum'
  end

  context 'raw LZO data' do
    xit 'handles encodings gracefully'
  end

  describe '::compress' do
    xit 'handles file IO'
    xit 'handles non-seekable IO'

    it 'handles strings' do
      original = 'The quick brown fox jumps over the lazy dog'
      compressed = LZO.compress original
      decompressed = LZO.decompress compressed
      expect(decompressed).to eq(original)
    end

    it 'supports lzop too' do
      Timecop.freeze Date.new(1989, 4, 25) do
        compressed = LZO.compress 'aaa' * 100, lzop: true
        expected = File.binread fixture_path 'nameless_compressor_output.txt.lzo'
        expect(compressed).to eq(expected)
      end
    end
  end

  describe '::decompress' do
    xit 'fails on invalid data'
  end
end
