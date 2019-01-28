
module LibPath
module Internal_

module Array

	def self.index(ar, v, after = nil)

		if after

			if after < 0

				after = ar.size + after

				return nil if after < 0
			else

				return nil unless after < ar.size
			end

			ar.each_with_index do |el, ix|

				if ix >= after

					if v == el

						return ix
					end
				end
			end

			nil
		else

			ar.index(v)
		end
	end

	def self.index2(ar, v1, v2, after = nil)

		i_1	=	self.index(ar, v1, after)
		i_2	=	self.index(ar, v2, after)

		if i_1

			if i_2

				i_1 < i_2 ? i_2 : i_1
			else

				i_1
			end
		else

			i_2
		end
	end


	def self.rindex2(ar, v1, v2)

		i_1	=	ar.rindex(v1)
		i_2	=	ar.rindex(v2)

		if i_1

			if i_2

				i_1 < i_2 ? i_1 : i_2
			else

				i_1
			end
		else

			i_2
		end
	end

end

end
end


