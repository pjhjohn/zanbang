class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    # raise "#{params.inspect}"
    @filter_is_oneroom      = params[:filter_is_oneroom     ]
    @filter_location        = params[:filter_location       ]
    @filter_is_male         = params[:filter_is_male        ]
    @filter_monthly_pay_min = params[:filter_monthly_pay_min]
    @filter_monthly_pay_max = params[:filter_monthly_pay_max]
    @filter_in_date         = DateTime.parse(params[:filter_in_date ] || "2010-01-01 00:00:00")
    @filter_out_date        = DateTime.parse(params[:filter_out_date] || "2020-12-31 23:59:59")
    @rooms = Room.where(deleted: false)
    @rooms = @rooms.where(is_oneroom:        @filter_is_oneroom)        unless @filter_is_oneroom.nil?
    @rooms = @rooms.where(is_male:           @filter_is_male)           unless @filter_is_male.nil?
    @rooms = @rooms.where(location:          @filter_location)          unless @filter_location.nil?
    @rooms = @rooms.where("in_date > ?",     @filter_in_date - 7.days)  unless @filter_in_date.nil?
    @rooms = @rooms.where("out_date < ?",    @filter_out_date + 7.days) unless @filter_out_date.nil?
    @rooms = @rooms.where("monthly_pay > ?", @filter_monthly_pay_min)   unless @filter_monthly_pay_min.nil?
    @rooms = @rooms.where("monthly_pay < ?", @filter_monthly_pay_max)   unless @filter_monthly_pay_max.nil?
  end

  def detail
    @room = Room.find_by_id(params[:room_id])
  end

  def new
  end

  def edit
    @room = Room.find_by_id(params[:room_id])
  end

  def remove
    @room = Room.find_by_id(params[:room_id])
  end

  # CRUD
  def create
    room = Room.new
    room.user_id        = current_user.id
    room.is_male        = current_user.is_male
    room.is_oneroom     = params[:is_oneroom    ] == true
    room.location       = params[:location      ].to_i
    room.address        = params[:address       ]
    room.lat            = params[:lat           ].to_f
    room.lng            = params[:lng           ].to_f
    room.insurance_pay  = params[:insurance_pay ].to_i
    room.monthly_pay    = params[:monthly_pay   ].to_i
    room.admin_pay      = params[:admin_pay     ].to_i
    room.admin_options  = params[:admin_options ]
    room.in_date        = DateTime.parse(params[:in_date ])
    room.out_date       = DateTime.parse(params[:out_date])
    room.room_type      = params[:room_type     ].to_i
    room.room_size      = params[:room_size     ].to_i
    room.room_floor     = params[:room_floor    ].to_i
    room.elevator       = params[:elevator      ] == true
    room.parking        = params[:parking       ] == true
    room.options        = params[:options       ]
    room.description    = params[:description   ]
    room.image1         = params[:image1        ] unless params[:image1].nil?
    room.image2         = params[:image2        ] unless params[:image2].nil?
    room.image3         = params[:image3        ] unless params[:image3].nil?
    room.image4         = params[:image4        ] unless params[:image4].nil?
    room.image5         = params[:image5        ] unless params[:image5].nil?
    room.representative = params[:representative] unless params[:representative].nil?
    room.save
    redirect_to "/"
  end

  def update
    room = Room.find_by_id(params[:room_id])
    unless room.nil?
      room.is_oneroom     = params[:is_oneroom    ]
      room.location       = params[:location      ]
      room.address        = params[:address       ]
      room.lat            = params[:lat           ]
      room.lng            = params[:lng           ]
      room.insurance_pay  = params[:insurance_pay ]
      room.monthly_pay    = params[:monthly_pay   ]
      room.admin_pay      = params[:admin_pay     ]
      room.admin_options  = params[:admin_options ]
      room.in_date        = params[:in_date       ]
      room.out_date       = params[:out_date      ]
      room.room_type      = params[:room_type     ]
      room.room_size      = params[:room_size     ]
      room.room_floor     = params[:room_floor    ]
      room.elevator       = params[:elevator      ]
      room.parking        = params[:parking       ]
      room.options        = params[:options       ]
      room.description    = params[:description   ]
      room.image1         = params[:image1        ] unless params[:image1].empty?
      room.image2         = params[:image2        ] unless params[:image2].empty?
      room.image3         = params[:image3        ] unless params[:image3].empty?
      room.image4         = params[:image4        ] unless params[:image4].empty?
      room.image5         = params[:image5        ] unless params[:image5].empty?
      room.representative = params[:representative] unless params[:representative].empty?
      room.save
    end
    redirect_to "/"
  end

  def delete
    room = Room.find_by_id(params[:room_id])
    unless room.nil?
      room.deleted = true
      room.completed = false
      room.save
    end
    redirect_to "/"
  end
  def complete
    room = Room.find_by_id(params[:room_id])
    unless room.nil?
      room.deleted = true
      room.completed = true
      room.save
    end
    redirect_to "/"
  end
end
