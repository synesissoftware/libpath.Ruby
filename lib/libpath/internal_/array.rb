
module LibPath
module Internal_

module Array

	def self.index2(ar, v1, v2)

		i_1	=	ar.rindex(v1)
		i_2	=	ar.rindex(v2)

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

end

end
end


