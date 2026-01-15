# deep_sum_spec.rb
require_relative '../deep_sum'

RSpec.describe Array, '#deep_sum' do
  it 'returns 0 for empty array' do
    expect([].deep_sum).to eq(0)
  end

  it 'sums a flat array of integers' do
    expect([1, 2, 3].deep_sum).to eq(6)
  end

  it 'handles positive and negative integers' do
    expect([1, -2, 3].deep_sum).to eq(2)
  end

  it 'handles floats' do
    expect([1.5, 2.5].deep_sum).to eq(4.0)
  end

  it 'ignores nil, string, boolean, object' do
    expect([1, nil, "2", true, Object.new, 3].deep_sum).to eq(4)
  end

  it 'ignores hashes completely' do
    expect([1, { a: 2 }, 3].deep_sum).to eq(4)
  end

  it 'sums nested arrays' do
    expect([1, [2, [3]]].deep_sum).to eq(6)
  end

  it 'handles deeply nested mixed values' do
    input = [
      1,
      "a",
      nil,
      true,
      Object.new,
      [
        -2,
        "b",
        [
          3.5,
          false,
          [nil, 4]
        ]
      ]
    ]

    expect(input.deep_sum).to eq(6.5)
  end

  it 'returns 0 for arrays with no numeric values' do
    expect([nil, "a", true, {}, []].deep_sum).to eq(0)
  end

  it 'handles empty nested arrays' do
    expect([[[]]].deep_sum).to eq(0)
  end

  it 'handles long arrays' do
    expect((1..100).to_a.deep_sum).to eq(5050)
  end

  it 'handles long arrays with junk values' do
    input = (1..10).to_a + ["a", nil, true, Object.new] + [-5, 2.5]
    expect(input.deep_sum).to eq(52.5)
  end
end
