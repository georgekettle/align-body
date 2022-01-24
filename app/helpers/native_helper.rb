module NativeHelper
  def is_native?
    cookies[:is_native] == "true"
  end

  def is_web?
    cookies[:is_native] != "true"
  end
end