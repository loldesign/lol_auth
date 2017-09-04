json.message 'success'
json.data do
	json.partial! 'user', user: @user
end
